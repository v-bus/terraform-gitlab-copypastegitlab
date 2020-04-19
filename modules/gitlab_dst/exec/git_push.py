from terraform_external_data import terraform_external_data
import os
import json_logging, logging, sys
import traceback
import subprocess

# enable json logging
json_logging.ENABLE_JSON_LOGGING = True
json_logging.init_non_web()

logger = logging.getLogger("clone-it-logger")
logger.setLevel(logging.DEBUG)

class StreamToLogger(object):
    """
    Fake file-like stream object that redirects writes to a logger instance.
    """
    def __init__(self, logger, log_level=logging.INFO):
        self.logger = logger
        self.log_level = log_level
        self.linebuf = ''

    def write(self, buf):
        temp_linebuf = self.linebuf + buf
        self.linebuf = ''
        for line in temp_linebuf.splitlines(True):
            # From the io.TextIOWrapper docs:
            #   On output, if newline is None, any '\n' characters written
            #   are translated to the system default line separator.
            # By default sys.stdout.write() expects '\n' newlines and then
            # translates them so this is still cross platform.
            if line[-1] == '\n':
                self.logger.log(self.log_level, line.rstrip())
            else:
                self.linebuf += line

    def flush(self):
        if self.linebuf != '':
            self.logger.log(self.log_level, self.linebuf.rstrip())
        self.linebuf = ''

sl = StreamToLogger(logger, logging.ERROR)
sys.stderr = sl


@terraform_external_data
def clone_it(query):
    """
    Function clone project from source to specified directory
    Creates group/subgroup folders change directory to it
    and clone git project SSH
    """
    logger.addHandler(logging.FileHandler(query['logfile']))
    logger.info(str(query))
    error_msg = "Ok"
    try:
        git_dir = os.path.join(query['workdir'], query['repodir'])
        os.chdir(git_dir)
        error_msg = subprocess.getoutput("git remote set-url origin "+query['project_ssh'])
        error_msg += subprocess.getoutput("git push --force --all")
    
    except ValueError as val_err:
        error_msg+="Value error {0}".format(val_err)
    except FileExistsError as file_exists:
        error_msg+="File Exists {0}".format(file_exists)
    except NameError as ne:
        error_msg+="Name error {0}".format(ne)
    except:
        traceback.print_exc(file=sys.stdout)
    
    logger.error(error_msg)
    return {query['project_ssh']: error_msg}


if __name__ == '__main__':
    # Always protect Python scripts from import side effects with
    # a condition to check the __name__. Not specifically necessary
    # for terraform_external_data, but it's a best practice in general.
    clone_it()