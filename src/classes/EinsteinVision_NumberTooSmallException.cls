public class EinsteinVision_NumberTooSmallException extends Exception {
    
    public EinsteinVision_NumberTooSmallException (String field, Decimal minValue, Decimal currentValue) {
        setMessage('The minimum allowed size for "' + field + '" is ' + minValue + ' (current: ' + currentValue + ').'); 
    }

}