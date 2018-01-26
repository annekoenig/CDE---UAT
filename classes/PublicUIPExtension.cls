public class PublicUIPExtension {
    
    public boolean isPageChanged { get; set; }

    public PublicUIPExtension(ApexPages.StandardController stdController) {
    }
    
    public void setPageChanged() {
        isPageChanged = true;
    } 
    
}