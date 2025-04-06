public with sharing class InsightExternalDataPartFactory {
    
    public static InsightsExternalDataPart createInsightExternalDataPart(Blob DataFile, String InsightsExternalDataId, Integer PartNumber) {
        
        InsightsExternalDataPart insightExternalDataPart = new InsightsExternalDataPart();
        
        insightExternalDataPart.DataFile = DataFile;
        insightExternalDataPart.InsightsExternalDataId = InsightsExternalDataId;
        insightExternalDataPart.PartNumber = PartNumber;
        
        return insightExternalDataPart;
    }
}