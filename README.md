# Salesforce Aegist Metrics

Aegis Metrics was created after we identified the need to capture all Salesforce events generated to CRM Analytics, allowing us to build metrics and KPIs and gain deeper insights into user interactions within the Salesforce platform.

## Project Structure

The project is organized as follows:

- **force-app/main/default/lwc**: Contains Lightning Web Components (LWCs) such as `AegisMetricsSetup`.
- **scripts**: Contains Apex and SOQL scripts for automation and testing.
- **config**: Includes project configuration files like `project-scratch-def.json`.
- **manifest**: Contains the `package.xml` file for metadata deployment.

## Key Features

- **AegisMetricsSetup LWC**: 
  - Displays and manages monitoring types.
  - Fetches monitoring types using the Apex method `AegisMetricsServices.getMonitoringTypes`.
  - Filters monitoring types into `defaultMonitoringTypes` and `enabledMonitoringTypes`.

- **Apex Services**:
  - `AegisMetricsServices`: Provides backend logic for fetching monitoring types.

## Setup Instructions

1. **Install Salesforce CLI**: Follow the [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm).
2. **Clone the Repository**:
   ```sh
   git clone <repository-url>
   cd <repository-folder>