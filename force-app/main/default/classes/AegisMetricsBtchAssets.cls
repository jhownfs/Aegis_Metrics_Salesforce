public with sharing class AegisMetricsBtchAssets implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Name FROM ApexClass WHERE NamespacePrefix = null';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Ativo_Tecnologico__c> ativosParaUpsert = new List<Ativo_Tecnologico__c>();

        for (SObject s : scope) {
            ApexClass ac = (ApexClass)s;
            String nomeDaClasse = ac.Name;

            Ativo_Tecnologico__c ativo = new Ativo_Tecnologico__c(
                Name = nomeDaClasse, 
                Tipo_de_Ativo__c = 'Apex Class',
                Status_Monitoramento__c = true 
            );
            ativosParaUpsert.add(ativo);
        }

        if (!ativosParaUpsert.isEmpty()) {
           
            Database.upsert(ativosParaUpsert, Ativo_Tecnologico__c.Fields.Name, false);
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch de Descoberta de Ativos Tecnológicos (Apex Class) concluído com sucesso.');
    }
}