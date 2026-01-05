#Defines a function to access the files in the .env file
def loadEnv(fileName: str) -> str:
    """
    Docstring for getAPIKey

    Access the API KEY from the .env file

    Parameters:
    ----------
    fileName    :   str
                The name of the file in .env to access

    Returns:
    -------
    data    :   str
            The data contained in the file provided in the .env file
    """
    #imports os
    import os

    #Imports load_dotenv from dotenv
    from dotenv import load_dotenv

    load_dotenv()

    data = os.getenv(fileName)

    return data if data != None else f"{fileName} was not found in the .env file"



def main():
    print(f"The database name is: {loadEnv(fileName="database")}")



if __name__ == "__main__":
    main()