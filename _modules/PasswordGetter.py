"""All passwords that are kept in the passwods.ini file can be retrieved with
this module"""

import ConfigParser

def get_password(program_name):
    """Looks in the passwords.ini file and returns the password for the program

    Args:
        program_name: The name of the program to get the password for

    Returns:
        The password for the given program_name
    """
    config = ConfigParser.ConfigParser()
    config.read("/home/max/my-salt-states/passwords.ini")
    return config.get("passwords", program_name)
