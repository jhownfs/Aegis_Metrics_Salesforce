public with sharing class AegisSchemaGenerator {

    private map<String,String> fieldsLogFile;
    private String logName = 'AegisMetrics';

    public AegisSchemaGenerator(map<String,String> fieldsLogFile, String logName) {
        
        this.fieldsLogFile = fieldsLogFile;
        this.logName = logName;
    }

    public void generetaSchemaEventlog(){

        List<Field> dynamicFields = new List<Field>();

        for(String key : fieldsLogFile.keySet()) {
            String value = fieldsLogFile.get(key);
            dynamicFields.add(createField(key, value));
        }

        String schema = generateSchema(this.logName, 'Aegis Metrics', dynamicFields);
        System.debug('schema = ' + schema);
    }

    public class FileFormat {
        public String charsetName = 'UTF-8';
        public String fieldsDelimitedBy = ',';
        public String fieldsEnclosedBy = '"';
        public Integer numberOfLinesToIgnore = 1;
        
    }

    public class Field {
        public String fullyQualifiedName;
        public String name;
        public String type;
        public String label;
        public Integer precision;
        public Integer scale;
        public String defaultValue;
        public String format;
        public String decimalSeparator;
    }

    public class ObjectDefinition {
        public String connector = 'AegisCSVConnector';
        public String description;
        public String fullyQualifiedName;
        public String label;
        public String name;
        public List<Field> fields;
    }

    public class JsonSchema {
        public FileFormat fileFormat;
        public List<ObjectDefinition> objects;
    }

    public String generateSchema(String objectName, String description, List<Field> dynamicFields) {
        JsonSchema schema = new JsonSchema();
        schema.fileFormat = new FileFormat();

        ObjectDefinition obj = new ObjectDefinition();
        obj.name = objectName;
        obj.fullyQualifiedName = objectName;
        obj.label = objectName;
        obj.description = description;
        obj.fields = dynamicFields;

        schema.objects = new List<ObjectDefinition>{ obj };

        return JSON.serializePretty(schema, true);
    }

    public Field createField(String name, String type) {
        Field field = new Field();
        field.name = name;
        field.fullyQualifiedName = name;
        field.type = type;
        field.label = name;
        if(type == 'Number') {
          field.type = 'Numeric';  
          field.precision = 18;
          field.scale = 3;
          field.defaultValue = '0';
          field.format = '0.000';
          field.decimalSeparator = '.';
        } else if(type == 'Date' || type == 'Datetime') {
          field.format ='yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
        }

        return field;
    }
}