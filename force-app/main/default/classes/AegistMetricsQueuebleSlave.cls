public with sharing class AegistMetricsQueuebleSlave implements Queueable {

    private Eventlogfile eventLogFile;

    public AegistMetricsQueuebleSlave( Eventlogfile eventLogFile ){
        // Constructor logic can be added here if needed
        this.eventLogFile = eventLogFile;
    }

    public void execute(QueueableContext context) {
       
        try {

                InsightsExternalData insightExternalData = InsightExternalDataFactory.createInsightExternalData(this.eventLogFile.EventType);

                Database.insert(insightExternalData);

                Blob fileContent = this.eventLogFile.LogFile;

                InsightsExternalDataPart insightExternalDataPart = InsightExternalDataPartFactory.createInsightExternalDataPart(fileContent, insightExternalData.Id, 1);
           
                Database.insert(insightExternalDataPart);

                insightExternalData.Action = 'Process';
                
                Database.update(insightExternalData);
            
        } catch (Exception ex) {
            System.debug(ex.getMessage());
        } 


    }
}