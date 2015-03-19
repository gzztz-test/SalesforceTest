public  class MerchandiseUtility {
    public static void mainProcessing(){
        try{
            insertMerchandise();
        }catch(MerchandiseException m){
            System.debug('Message'+m.getMessage());
            System.debug('Cause'+m.getCause());
            System.debug('Line number'+m.getLineNumber());
            System.debug('Stack track'+m.getStackTrackString());
        }
        
    }
    public static void insertMerchandise(){
        try{
            Merchandise__c m = new Merchandise__c();
            insert m;
        }catch(DmlException e){
            throw new MerchandiseException('Merchandise item could not be inserted',e);
        }
    }
}