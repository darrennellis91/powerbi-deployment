The following PowerShell scripts are modified versions of https://github.com/microsoft/PowerBI-Developer-Samples/blob/master/PowerShell%20Scripts/Export-PowerBIReport.ps1


Login: This script installs necessary modules and initializes the Power BI service account.
Export Pbix: Downloads an existing Power BI report by using the workspace name and report ID. The report is saved in the folder where the script is executed.
Import All: Goes through a list of workspace names and uploads the specified Pbix file from the executing folder into each workspace.
Trigger All: Runs through a list of pipeline names, executing deployment stage 0 or 1. Stage 0 corresponds to the development to test phase, and stage 1 corresponds to the test to production phase.
Refresh All: Cycles through a list of report names and triggers a refresh of their respective datasets.
