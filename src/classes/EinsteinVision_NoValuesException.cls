public class EinsteinVision_NoValuesException extends Exception {

    public EinsteinVision_NoValuesException(String field, String check) {
        setMessage('You have not provided any values for "' + field + '".');
    }
    
}