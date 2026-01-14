import re

def extract_execution_time(line):
    """Extract actual execution time from a line."""
    match = re.search(r'actual time=(\d+\.?\d*)', line)
    if match:
        return float(match.group(1))
    return None

def calculate_total_time(plan_text):
    """Calculate total execution time from the plan."""
    lines = plan_text.strip().split('\n')
    max_time = 0
    
    for line in lines:
        time = extract_execution_time(line)
        if time:
            max_time = max(max_time, time)
    
    return max_time

def print_query_plan(plan_text):
    """Print query execution plan from bottom to top in a user-friendly format."""
    # Handle ResultSet object from SQL magic commands
    if hasattr(plan_text, '__iter__') and not isinstance(plan_text, str):
        # Extract the EXPLAIN output from the ResultSet
        # The plan is typically in the first column of the result
        plan_text = '\n'.join([str(row[0]) for row in plan_text])
    
    lines = plan_text.strip().split('\n')
    
    # Reverse the lines to print from bottom to top
    reversed_lines = lines[::-1]
    
    print("=" * 80)
    print("QUERY EXECUTION PLAN")
    print("=" * 80)
    print()
    
    for i, line in enumerate(reversed_lines, 1):
        # Clean up the line
        cleaned_line = line.strip()
        
        # Extract indentation level from original line
        indent_level = len(line) - len(line.lstrip())
        
        # Calculate reverse indent (deeper operations appear first now)
        reverse_indent = len(lines) - i
        
        # Extract execution time if present
        time_match = re.search(r'actual time=(\d+\.?\d*)\.\.(\d+\.?\d*)', cleaned_line)
        rows_match = re.search(r'rows=(\d+)', cleaned_line)
        cost_match = re.search(r'cost=(\d+\.?\d*)', cleaned_line)
        
        
        # Add step number
        step_info = f"[Step {i}] "
        
        # Extract operation and its details (everything before cost/actual time)
        # Split by '  (' to separate operation from metrics
        parts = re.split(r'\s{2}\(', cleaned_line, maxsplit=1)
        operation = parts[0].replace('->', '').strip()
        
        print(f"{step_info}{operation}")
        
        # Print additional details on separate lines for clarity
        if time_match:
            start_time = time_match.group(1)
            end_time = time_match.group(2)
            print(f"         Execution Time: {start_time}..{end_time} ms")
        
        if rows_match:
            rows = rows_match.group(1)
            print(f"         Rows: {rows}")
        
        if cost_match:
            cost = cost_match.group(1)
            print(f"         Cost: {cost}")
        
        print()
    
    # Calculate and print total execution time
    total_time = calculate_total_time(plan_text)
    
    print("=" * 80)
    print(f"TOTAL QUERY EXECUTION TIME: {total_time:.3f} ms")
    print("=" * 80)

def main():
    # Example usage
    query_plan = """-> Sort: `month`, s.specialty_name, e.encounter_type  (actual time=0.333..0.334 rows=4 loops=1)
        -> Stream results  (actual time=0.309..0.315 rows=4 loops=1)
            -> Group aggregate: count(encounters.encounter_id), count(distinct encounters.patient_id)  (actual time=0.305..0.308 rows=4 loops=1)
                -> Sort: `year`, `month`, s.specialty_name, e.encounter_type  (actual time=0.287..0.287 rows=4 loops=1)
                    -> Stream results  (cost=3 rows=4) (actual time=0.145..0.181 rows=4 loops=1)
                        -> Nested loop inner join  (cost=3 rows=4) (actual time=0.136..0.168 rows=4 loops=1)
                            -> Nested loop inner join  (cost=1.6 rows=3) (actual time=0.0982..0.11 rows=3 loops=1)
                                -> Filter: (p.specialty_id is not null)  (cost=0.55 rows=3) (actual time=0.0647..0.0681 rows=3 loops=1)
                                    -> Covering index scan on p using specialty_id  (cost=0.55 rows=3) (actual time=0.0638..0.0664 rows=3 loops=1)
                                -> Single-row index lookup on s using PRIMARY (specialty_id = p.specialty_id)  (cost=0.283 rows=1) (actual time=0.0132..0.0134 rows=1 loops=3)
                            -> Index lookup on e using provider_id (provider_id = p.provider_id)  (cost=0.378 rows=1.33) (actual time=0.0153..0.0181 rows=1.33 loops=3)"""

    # Print the query plan
    print_query_plan(query_plan)

if __name__ == "__main__":
    main()