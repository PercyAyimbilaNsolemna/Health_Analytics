def read_sql_file(filename):
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            sql_script = f.read()
    except FileNotFoundError:
        print(f"Invalid file path: {filename}")
        return None
    
    return sql_script


def main():
    sql_content = read_sql_file('your_sql_file.sql')

    print(sql_content) if sql_content is not None else print("An invalid Filepath was given")



if __name__ == "__main__":
    main()