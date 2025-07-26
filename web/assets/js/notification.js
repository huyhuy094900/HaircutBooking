// Notification System for HaircutBooking
class NotificationSystem {
    constructor() {
        this.audio = null;
        this.isInitialized = false;
        this.init();
    }
    
    init() {
        this.createAudioElement();
        this.requestPermission();
        this.isInitialized = true;
    }
    
    createAudioElement() {
        // Create audio element with a pleasant notification sound
        this.audio = new Audio();
        this.audio.src = this.generateNotificationSound();
        this.audio.preload = 'auto';
        this.audio.volume = 0.6;
    }
    
    generateNotificationSound() {
        // Generate a pleasant notification sound using Web Audio API
        const audioContext = new (window.AudioContext || window.webkitAudioContext)();
        const oscillator = audioContext.createOscillator();
        const gainNode = audioContext.createGain();
        
        oscillator.connect(gainNode);
        gainNode.connect(audioContext.destination);
        
        oscillator.frequency.setValueAtTime(800, audioContext.currentTime);
        oscillator.frequency.setValueAtTime(1000, audioContext.currentTime + 0.1);
        oscillator.frequency.setValueAtTime(600, audioContext.currentTime + 0.2);
        
        gainNode.gain.setValueAtTime(0, audioContext.currentTime);
        gainNode.gain.linearRampToValueAtTime(0.3, audioContext.currentTime + 0.05);
        gainNode.gain.linearRampToValueAtTime(0, audioContext.currentTime + 0.3);
        
        oscillator.start(audioContext.currentTime);
        oscillator.stop(audioContext.currentTime + 0.3);
        
        return 'data:audio/wav;base64,UklGRnoGAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQoGAACBhYqFbF1fdJivrJBhNjVgodDbq2EcBj+a2/LDciUFLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBSuBzvLZiTYIG2m98OScTgwOUarm7blmGgU7k9n1unEiBC13yO/eizEIHWq+8+OWT';
    }
    
    requestPermission() {
        if ('Notification' in window) {
            Notification.requestPermission();
        }
    }
    
    playSound() {
        if (this.audio) {
            this.audio.currentTime = 0;
            this.audio.play().catch(e => {
                console.log('Audio play failed:', e);
                // Fallback to Web Audio API
                this.playFallbackSound();
            });
        }
    }
    
    playFallbackSound() {
        try {
            const audioContext = new (window.AudioContext || window.webkitAudioContext)();
            const oscillator = audioContext.createOscillator();
            const gainNode = audioContext.createGain();
            
            oscillator.connect(gainNode);
            gainNode.connect(audioContext.destination);
            
            oscillator.frequency.setValueAtTime(800, audioContext.currentTime);
            oscillator.frequency.setValueAtTime(1000, audioContext.currentTime + 0.1);
            oscillator.frequency.setValueAtTime(600, audioContext.currentTime + 0.2);
            
            gainNode.gain.setValueAtTime(0, audioContext.currentTime);
            gainNode.gain.linearRampToValueAtTime(0.3, audioContext.currentTime + 0.05);
            gainNode.gain.linearRampToValueAtTime(0, audioContext.currentTime + 0.3);
            
            oscillator.start(audioContext.currentTime);
            oscillator.stop(audioContext.currentTime + 0.3);
        } catch (e) {
            console.log('Fallback sound failed:', e);
        }
    }
    
    showNotification(title, message, options = {}) {
        // Play sound
        this.playSound();
        
        // Browser notification
        if ('Notification' in window && Notification.permission === 'granted') {
            const notification = new Notification(title, {
                body: message,
                icon: '/assets/img/logo.png',
                badge: '/assets/img/favicon.png',
                tag: 'haircutbooking-notification',
                requireInteraction: false,
                ...options
            });
            
            // Auto close after 5 seconds
            setTimeout(() => {
                notification.close();
            }, 5000);
        }
        
        // Visual toast notification
        this.showToastNotification(title, message, options);
    }
    
    showToastNotification(title, message, options = {}) {
        // Create toast container if it doesn't exist
        let toastContainer = document.getElementById('toastContainer');
        if (!toastContainer) {
            toastContainer = document.createElement('div');
            toastContainer.id = 'toastContainer';
            toastContainer.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
                max-width: 350px;
            `;
            document.body.appendChild(toastContainer);
        }
        
        // Create toast element
        const toast = document.createElement('div');
        toast.className = 'toast show';
        toast.style.cssText = `
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            margin-bottom: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            animation: slideInRight 0.5s ease-out;
            backdrop-filter: blur(10px);
        `;
        
        const icon = options.icon || '🎉';
        
        toast.innerHTML = `
            <div class="toast-header" style="background: transparent; border-bottom: 1px solid rgba(255,255,255,0.2);">
                <span style="font-size: 1.2rem; margin-right: 8px;">${icon}</span>
                <strong class="me-auto">${title}</strong>
                <button type="button" class="btn-close btn-close-white" onclick="this.parentElement.parentElement.remove()"></button>
            </div>
            <div class="toast-body">
                ${message}
            </div>
        `;
        
        toastContainer.appendChild(toast);
        
        // Auto remove after 5 seconds
        setTimeout(() => {
            if (toast.parentElement) {
                toast.style.animation = 'slideOutRight 0.5s ease-out';
                setTimeout(() => {
                    if (toast.parentElement) {
                        toast.remove();
                    }
                }, 500);
            }
        }, 5000);
    }
    
    // Check for new completed bookings
    checkNewCompletions(storageKey = 'completedCount') {
        const currentCompleted = document.querySelectorAll('.badge.bg-info').length;
        const previousCompleted = sessionStorage.getItem(storageKey) || 0;
        
        if (currentCompleted > previousCompleted) {
            this.showNotification(
                '🎉 Dịch vụ hoàn thành!', 
                'Có lịch hẹn mới được hoàn thành bởi staff.',
                { icon: '✅' }
            );
            sessionStorage.setItem(storageKey, currentCompleted);
        }
    }
    
    // Start monitoring for new completions
    startMonitoring(interval = 30000, storageKey = 'completedCount') {
        setInterval(() => {
            this.checkNewCompletions(storageKey);
        }, interval);
    }
}

// Add CSS animations
const notificationStyles = document.createElement('style');
notificationStyles.textContent = `
    @keyframes slideInRight {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOutRight {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
    
    .toast {
        transition: all 0.3s ease;
    }
    
    .toast:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0,0,0,0.3);
    }
`;

document.head.appendChild(notificationStyles);

// Export for use in other files
window.NotificationSystem = NotificationSystem; 