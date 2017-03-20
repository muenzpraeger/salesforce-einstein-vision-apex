public class EinsteinVision_StringIsEmptyException extends Exception {
    
    public EinsteinVision_StringIsEmptyException(String field, String check) {
        setMessage('The field "' + field + '" cannot be empty.');
    }

}