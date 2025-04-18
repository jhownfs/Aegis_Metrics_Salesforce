public with sharing class AegisMetricsQueuebleSlave implements Queueable {

    private Eventlogfile eventLogFile;

    public AegisMetricsQueuebleSlave( Eventlogfile eventLogFile ){
        // Constructor logic can be added here if needed
        this.eventLogFile = eventLogFile;
    }

    public void execute(QueueableContext context) {
       
        try { 
              
              // Add the event log file to the map
              List<String> fieldNames = this.eventLogFile.LogFileFieldNames.split(',');
              List<String> fieldTypes = this.eventLogFile.LogFileFieldTypes.split(',');

              map<String,String> eventLogFileJson = new map<String,String>();

              for(Integer i = 0; i < fieldNames.size(); i++) {

                eventLogFileJson.put(fieldNames[i], fieldTypes[i]);

              }

              AegisMetricsSchemaGenerator schemaGenerator = new AegisMetricsSchemaGenerator(eventLogFileJson, this.eventLogFile.EventType);

              Blob schemaBlob = Blob.valueOf(schemaGenerator.generetaSchemaEventlog());

              InsightsExternalData insightExternalData = AegisMetricsInsightExternalDataFactory.createInsightExternalData(this.eventLogFile.EventType, schemaBlob);
              
              Database.insert(insightExternalData);

              Blob fileContent = this.eventLogFile.LogFile;

              InsightsExternalDataPart insightExternalDataPart = AegisMetricsInsightExternalDataPtFactory.createInsightExternalDataPart(fileContent, insightExternalData.Id, 1);
           
              Database.insert(insightExternalDataPart);

              insightExternalData.Action = 'Process';
                
              Database.update(insightExternalData);
            
        } catch (Exception ex) {
            System.debug(ex.getMessage());
        } 


    }
}