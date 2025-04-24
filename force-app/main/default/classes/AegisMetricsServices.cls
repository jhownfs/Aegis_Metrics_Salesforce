public with sharing class AegisMetricsServices {
 
    private static final String CRONJOBNAME = 'AegisMetricsUploadEventLogFiles';

    @AuraEnabled
    public static  list<Event_Monitoring_Type__mdt> getMonitoringTypes(){

        List<Event_Monitoring_Type__mdt> eventMonitoringTypes = new List<Event_Monitoring_Type__mdt>();

        try {
            
            eventMonitoringTypes = AegisMetricsEventMonitoringTypesSelector.getAllEventMonitoringTypes();

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return eventMonitoringTypes;
    }

    @AuraEnabled
    public static Boolean updateEventTypes(String jsonData) {

        Boolean isSuccess = false;

        Event_Monitoring_Type__mdt eventTypes = (Event_Monitoring_Type__mdt) JSON.deserialize(jsonData, Event_Monitoring_Type__mdt.class);

        List<Event_Monitoring_Type__mdt> eventMonitoringTypes = AegisMetricsEventMonitoringTypesSelector.getEventMonitoringTypeById(eventTypes.Id);

        try {

            Metadata.CustomMetadata metaDataRecord = new Metadata.CustomMetadata();
            metaDataRecord.FullName = 'Event_Monitoring_Type__mdt.' + eventMonitoringTypes[0].DeveloperName;
            metaDataRecord.Label = eventMonitoringTypes[0].MasterLabel;
    
            Metadata.CustomMetadataValue metaDataValue = new Metadata.CustomMetadataValue();
            metaDataValue.Field = 'Enabled_To_Ingest__c';
            metaDataValue.Value = eventTypes.Enabled_To_Ingest__c;
    
            metaDataRecord.values.add(metaDataValue);
    
            Metadata.DeployContainer container = new Metadata.DeployContainer();
            container.addMetadata(metaDataRecord);
    
            Metadata.Operations.enqueueDeployment(container, null);
            isSuccess = true;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return isSuccess;
    }

    @AuraEnabled(cacheable=true)
    public static String getNextExecutionTime() {
        List<CronTrigger> cron = [
            SELECT NextFireTime 
            FROM CronTrigger 
            WHERE CronJobDetail.Name =: CRONJOBNAME
            ORDER BY NextFireTime ASC 
            LIMIT 1
        ];

        if (cron.isEmpty()) {
            return null;  
        }

        return String.valueOf(cron[0].NextFireTime);
    }

    @AuraEnabled
    public static void scheduleJob() {
        String cronExp = '0 0 20 * * ?'; // A dia
        System.schedule(CRONJOBNAME, cronExp, new AegisMetricsSch());
    }

    @AuraEnabled
    public static void deleteJob() {
        List<CronTrigger> jobs = [
            SELECT Id 
            FROM CronTrigger 
            WHERE CronJobDetail.Name =: CRONJOBNAME
        ];
        for (CronTrigger job : jobs) {
            System.abortJob(job.Id);
        }
    }
}