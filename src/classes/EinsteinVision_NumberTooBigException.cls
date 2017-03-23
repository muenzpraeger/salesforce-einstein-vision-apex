public class EinsteinVision_NumberTooBigException extends Exception {
    
    public EinsteinVision_NumberTooBigException (String field, Integer maxValue, Integer currentValue) {
        setMessage('The maximum allowed size for "' + field + '" is ' + maxValue + ' (current: ' + currentValue + ').'); 
    }
    
    public EinsteinVision_NumberTooBigException (String field, Decimal maxValue, Decimal currentValue) {
        setMessage('The maximum allowed size for "' + field + '" is ' + maxValue + ' (current: ' + currentValue + ').'); 
    }

}