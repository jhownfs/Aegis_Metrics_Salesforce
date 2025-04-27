public with sharing class AegisMetricsInsightExternalDataFactory {
  
    public static InsightsExternalData createInsightExternalData(String EdgemartAlias, Blob MetadataJson) {

        InsightsExternalData  insightExternalData = new InsightsExternalData();
        
        insightExternalData.EdgemartAlias = EdgemartAlias;
        insightExternalData.Format = 'Csv';
        insightExternalData.Operation = 'Append';
        insightExternalData.EdgemartContainer = 'AegisMetrics';
        insightExternalData.MetadataJson = MetadataJson;
        
        return insightExternalData;
    }
}