// Navigation Helper for Better Browser History
class NavigationHelper {
    
    // Navigate with proper history
    static navigate(url, replace = false) {
        if (replace) {
            window.location.replace(url);
        } else {
            window.location.href = url;
        }
    }
    
    // Go back with fallback
    static goBack() {
        if (window.history.length > 1) {
            window.history.back();
        } else {
            window.location.href = 'home';
        }
    }
    
    // Go forward with fallback
    static goForward() {
        if (window.history.length > 1) {
            window.history.forward();
        } else {
            window.location.href = 'home';
        }
    }
    
    // Add navigation buttons to pages
    static addNavigationButtons() {
        // Add back button if not exists
        if (!document.getElementById('nav-back-btn')) {
            const backBtn = document.createElement('button');
            backBtn.id = 'nav-back-btn';
            backBtn.className = 'btn btn-outline-secondary btn-sm';
            backBtn.innerHTML = '<i class="bi bi-arrow-left"></i> Quay lại';
            backBtn.onclick = () => this.goBack();
            
            // Insert at the beginning of main content
            const mainContent = document.querySelector('.container, .main-content');
            if (mainContent) {
                mainContent.insertBefore(backBtn, mainContent.firstChild);
            }
        }
    }
    
    // Handle form submissions to preserve history
    static handleFormSubmit(form, action, method = 'POST') {
        form.addEventListener('submit', function(e) {
            // Don't prevent default, let form submit normally
            // This preserves browser history
        });
    }
    
    // Initialize navigation helpers
    static init() {
        // Add navigation buttons on page load
        document.addEventListener('DOMContentLoaded', function() {
            NavigationHelper.addNavigationButtons();
        });
        
        // Handle browser back/forward buttons
        window.addEventListener('popstate', function(event) {
            // Reload page content if needed
            if (event.state && event.state.reload) {
                window.location.reload();
            }
        });
    }
}

// Auto-initialize when script loads
NavigationHelper.init();

// Global functions for easy access
function goBack() {
    NavigationHelper.goBack();
}

function goForward() {
    NavigationHelper.goForward();
}

function navigateTo(url) {
    NavigationHelper.navigate(url);
} 