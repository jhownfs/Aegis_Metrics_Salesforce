public with sharing class AegistMetricsQueuebleSlave implements Queueable, Database.AllowsCallouts {

    private Eventlogfile eventLogFile;

    public AegistMetricsQueuebleSlave( Eventlogfile eventLogFile ){
        // Constructor logic can be added here if needed
        this.eventLogFile = eventLogFile;
    }

    public void execute(QueueableContext context) {
       
        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL.getOrgDomainUrl().toExternalForm() + this.eventLogFile.LogFile);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());

        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setTimeout(120000); // Set timeout to 2 minutes 

        try {

            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {

                InsightsExternalData insightExternalData = InsightExternalDataFactory.createInsightExternalData(this.eventLogFile.EventType);

                Database.insert(insightExternalData);

                Blob fileContent = response.getBodyAsBlob(); 

                InsightsExternalDataPart insightExternalDataPart = InsightExternalDataPartFactory.createInsightExternalDataPart(fileContent, insightExternalData.Id, 1);
           
                Database.insert(insightExternalDataPart);

                insightExternalData.Action = 'Process';
                
                Database.update(insightExternalData);
            }
            
        } catch (Exception ex) {
            System.debug(ex.getMessage());
        } 


    }
}