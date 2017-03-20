public class EinsteinVision_NumberToBigException extends Exception {
    
    public EinsteinVision_NumberToBigException (String field, Integer maxValue, Integer currentValue) {
        setMessage('The maximum allowed size for "' + field + '" is ' + maxValue + ' (current: ' + currentValue + ').'); 
    }
    
    public EinsteinVision_NumberToBigException (String field, Double maxValue, Double currentValue) {
        setMessage('The maximum allowed size for "' + field + '" is ' + maxValue + ' (current: ' + currentValue + ').'); 
    }

}