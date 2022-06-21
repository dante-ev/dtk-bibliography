#!/usr/bin/env python3
"""
This script is used to upload a package to CTAN.
It uses curl to send the POST request.

Without any parameter it does just a sort of validation 
of the package to be uploaded

CAUTION: The validation is not as thorough as what `pkgcheck` does

If `--upload` is specified the package gets uploaded to CTAN.

If required it could be enhanced to be a generic script.

Based on a script written by Manfred Lotz
see https://gitlab.com/Lotz/pkgcheck/blob/master/ctan_upload.py
"""

import subprocess
import zipfile
from shutil import copyfile
from os import unlink
import toml
import re


def add_parm_from_toml(conf, parm, cmd):
    """
    Adds command line parameter(s) for the curl command

    - first get value from  toml file or None in case
      the `parm` is not specified
    - if the value gotten is a list add command line args for each
      iten in the list
    - if the value gotten is just a simple value add command line
      arg for that value
    """

    val = conf.get(parm)
    if val:
        if isinstance(val, list):
            for v in val:
                cmd.append("-F")
                cmd.append(parm + "=" + v)
        else:
            cmd.append("-F")
            cmd.append(parm + "=" + val)
    return cmd


def main(upload=False):
    """
    Parse command line args and invoke curl to either
    - validate an upload, or
    - to upload a package to CTAN
    """
    

    print('Do not forget to update the .toml file, .tex and the README file in the sub-folder!')
    # This TOML file is not included as it
    # contains sensitive information
    conf = toml.load('dtk_bibliography.toml')

    pkg = conf["pkg"]
    pkg_version = conf["pkg_version"]
    pkg_zip = conf["pkg_zip"]
    uploader = conf["uploader"]
    email = conf["email"]
    ctan_path = conf["ctan_path"]


    with open("dtk-bibliography/README.md", "r+") as f:
        data = f.read()
        f.seek(0)
        f.write(re.sub(r"\$.*\$", conf["announcement"], data))
        f.truncate()


    # certain parameters are always required
    curl = ["curl"] + [
        "-i",
        "-X",
        "POST",
        "-F", "update=true",
        "-F", "pkg=" + pkg,
        "-F", "version=" + pkg_version,
        "-F", "email=" + email,
        "-F", "ctanPath=" + ctan_path,
        "-F", "uploader=" + uploader,
        "-F", "file=@" + pkg_zip,
    ]


    # the following parameters are optional
    add_parm_from_toml(conf, "summary", curl)
    add_parm_from_toml(conf, "description", curl)
    add_parm_from_toml(conf, "author", curl)
    add_parm_from_toml(conf, "home", curl)
    add_parm_from_toml(conf, "announcement", curl)
    add_parm_from_toml(conf, "support", curl)
    add_parm_from_toml(conf, "development", curl)
    add_parm_from_toml(conf, "repository", curl)
    add_parm_from_toml(conf, "bugs", curl)
    add_parm_from_toml(conf, "note", curl)
    add_parm_from_toml(conf, "licenses", curl)
    add_parm_from_toml(conf, "topics", curl)

    if upload == True:
        curl.append("https://www.ctan.org/submit/upload")
        print('Upload mode is on, uploading ZIP to CTAN!')
        
    else:
        curl.append("https://www.ctan.org/submit/validate")
        print('Validation mode is on, no upload!')

    rc = subprocess.run(curl).returncode
    if rc != 0:
        print(f"curl error: {rc}")
    else:
        print(f"curl had no error, returncode was: {rc}")


if __name__ == "__main__":
    # get latest versions of all files
    copyfile('dtk-authoryear.bbx'  , './dtk-bibliography/dtk-authoryear.bbx')
    copyfile('dtk-authoryear.dbx'  , './dtk-bibliography/dtk-authoryear.dbx')
    copyfile('dtk-bibliography.pdf', './dtk-bibliography/dtk-bibliography.pdf')
    copyfile('dtk-bibliography.tex', './dtk-bibliography/dtk-bibliography.tex')
    copyfile('dtk-bibliography.bib', './dtk-bibliography/dtk-bibliography.bib')
    copyfile('dtk-logos.sty', './dtk-bibliography/dtk-logos.sty')


    # create the zip file
    with zipfile.ZipFile('dtk-bibliography.zip', 'w', zipfile.ZIP_DEFLATED) as z:
        z.write('./dtk-bibliography/README.md')
        z.write('./dtk-bibliography/dtk-authoryear.bbx')
        z.write('./dtk-bibliography/dtk-authoryear.dbx')
        z.write('./dtk-bibliography/dtk-bibliography.pdf')
        z.write('./dtk-bibliography/dtk-bibliography.tex')
        z.write('./dtk-bibliography/dtk-bibliography.bib')
        z.write('./dtk-bibliography/dtk-logos.sty')

    # remove files again
    unlink('./dtk-bibliography/dtk-authoryear.bbx')
    unlink('./dtk-bibliography/dtk-authoryear.dbx')
    unlink('./dtk-bibliography/dtk-bibliography.pdf')
    unlink('./dtk-bibliography/dtk-bibliography.tex')
    unlink('./dtk-bibliography/dtk-bibliography.bib')
    unlink('./dtk-bibliography/dtk-logos.sty')

    
    # Update the README.MD in the subfolder!
    main(False) # Set to True to upload
    



