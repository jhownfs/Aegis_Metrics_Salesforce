// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

list<Event_Monitoring_Type__mdt> eventMonitoringTypes = EventMonitoringTypesSelector.getEnabledToIngestEventMonitoring();
system.debug('eventMonitoringTypes: ' + eventMonitoringTypes);

list<String> eventMonitoringTypeLabels = new List<String>();

for( Event_Monitoring_Type__mdt eventMonitoringType : eventMonitoringTypes ) {
    eventMonitoringTypeLabels.add(eventMonitoringType.MasterLabel.deleteWhitespace());
}
system.debug('eventMonitoringTypeLabels: ' + eventMonitoringTypeLabels);

 // Get the event log files for the enabled event monitoring types
list<Eventlogfile> eventLogFiles = EventLogFileSelector.getEventLogFiles(eventMonitoringTypeLabels);
   
map<String,String> eventLogFileMap = new map<String,String>();

for( Eventlogfile eventLogFile : eventLogFiles ) {
    // Add the event log file to the map
    List<String> fieldNames = eventLogFile.LogFileFieldNames.split(',');
    List<String> fieldTypes = eventLogFile.LogFileFieldTypes.split(',');

    for(Integer i = 0; i < fieldNames.size(); i++) {

      eventLogFileMap.put(fieldNames[i], fieldTypes[i]);

    }
    
}   

AegisSchemaGenerator schemaGenerator = new AegisSchemaGenerator(eventLogFileMap , 'DatabaseSave');

// Generate the schema for the event log file
schemaGenerator.generetaSchemaEventlog();

//System.enqueueJob(new AegistMetricsQueuebleSlave(eventLogFiles[0]));