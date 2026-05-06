import os
from crewai import Agent, Task, Crew, Process

# 1. Define Agents
data_engineer = Agent(
    role='Senior Data Engineer',
    goal='Extract customer behavior data and prepare it for risk modeling.',
    backstory="""You specialize in SQL and Python. You clean raw datasets, 
    handle missing values, and perform feature engineering to identify 
    patterns in customer churn.""",
    verbose=True,
    allow_delegation=False
)

risk_analyst = Agent(
    role='Risk Assessment Specialist',
    goal='Analyze processed data to predict churn probability and credit risk.',
    backstory="""You are an expert in statistical modeling. You take cleaned data 
    and apply logic to categorize customers into high, medium, or low risk segments.""",
    verbose=True,
    allow_delegation=True
)

bi_developer = Agent(
    role='Power BI Specialist',
    goal='Structure analysis results into a format ready for Power BI consumption.',
    backstory="""You transform complex analysis into structured JSON/CSV formats 
    and use scripts to trigger Power BI dataset refreshes via API.""",
    verbose=True
)

# 2. Define Tasks
task_extraction = Task(
    description='Extract the last 12 months of customer transaction and support logs. Clean the data.',
    expected_output='A cleaned CSV file containing customer interaction metrics.',
    agent=data_engineer
)

task_analysis = Task(
    description='Apply churn prediction logic and risk scoring to the cleaned dataset.',
    expected_output='A risk-scored dataset with churn probability percentages.',
    agent=risk_analyst
)

task_dashboard = Task(
    description='Convert final analysis into a Power BI-friendly format and push to the workspace.',
    expected_output='Confirmed data upload to Power BI workspace and report refresh trigger.',
    agent=bi_developer
)

# 3. Form the Crew
automation_crew = Crew(
    agents=[data_engineer, risk_analyst, bi_developer],
    tasks=[task_extraction, task_analysis, task_dashboard],
    process=Process.sequential
)

if __name__ == "__main__":
    # Execute
    result = automation_crew.kickoff()
    print(result)
