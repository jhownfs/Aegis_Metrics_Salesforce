// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

/*list<Event_Monitoring_Type__mdt> eventMonitoringTypes = EventMonitoringTypesSelector.getEnabledToIngestEventMonitoring();
system.debug('eventMonitoringTypes: ' + eventMonitoringTypes);

list<String> eventMonitoringTypeLabels = new List<String>();

for( Event_Monitoring_Type__mdt eventMonitoringType : eventMonitoringTypes ) {
    eventMonitoringTypeLabels.add(eventMonitoringType.MasterLabel.deleteWhitespace());
}
system.debug('eventMonitoringTypeLabels: ' + eventMonitoringTypeLabels);

 // Get the event log files for the enabled event monitoring types
list<Eventlogfile> eventLogFiles = EventLogFileSelector.getEventLogFiles(eventMonitoringTypeLabels);*/

String jsonData = '{ "MasterLabel" : "APITotalUsage"';
jsonData += ', "Log_File_Field_Names__c": ';
jsonData+='"API_FAMILY,API_RESOURCE,API_VERSION,CLIENT_IP,CLIENT_NAME,CONNECTED_APP_ID,CONNECTED_APP_NAME,COUNTS_AGAINST_API_LIMIT,ENTITY_NAME,EVENT_TYPE"';
jsonData += ', "Log_File_Field_Types__c": ';
jsonData+='"String,String,Number,String,String,String,String,Boolean,String,String"';
jsonData += '}'; 
AegisMetricsServices.uploadSampleData(jsonData);
   
/*map<String,String> eventLogFileMap = new map<String,String>();

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
String formatgenerated = schemaGenerator.generetaSchemaEventlog();

System.debug('eventLogFiles: ' + formatgenerated);

System.debug('schemaGenerator: ' + blob.valueOf(formatgenerated));*/

//System.enqueueJob(new AegisMetricsQueuebleSlave(eventLogFiles[0]));

