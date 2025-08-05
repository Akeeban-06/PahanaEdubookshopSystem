<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu Bookshop - Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
        }
        
        .login-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }
        
        .brand-gradient {
            background: linear-gradient(135deg, #3b82f6 0%, #6366f1 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        
        .login-btn {
            background: linear-gradient(135deg, #3b82f6 0%, #6366f1 100%);
            transition: all 0.3s ease;
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(59, 130, 246, 0.3);
        }
        
        .input-focus:focus {
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }
        
        .error-message {
            animation: fadeIn 0.3s ease-in-out;
        }
        
        .success-message {
            animation: fadeIn 0.3s ease-in-out;
        }
        
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            transform: translateX(150%);
            transition: transform 0.3s ease-in-out;
            z-index: 1000;
        }
        
        .toast.show {
            transform: translateX(0);
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4">
    <!-- Success Toast (shown when redirected from successful registration) -->
    <% if (request.getAttribute("success") != null) { %>
        <div id="successToast" class="toast show">
            <div class="bg-green-50 border-l-4 border-green-500 text-green-700 p-4 rounded-lg shadow-lg flex items-start max-w-xs">
                <i class="ri-checkbox-circle-fill text-green-500 text-xl mr-3"></i>
                <div>
                    <p class="font-medium"><%= request.getAttribute("success") %></p>
                    <p class="text-sm mt-1">Please login to continue</p>
                </div>
            </div>
        </div>
    <% } %>

    <div class="login-container max-w-md w-full rounded-2xl overflow-hidden shadow-xl border border-gray-100">
        <!-- Decorative header -->
        <div class="bg-gradient-to-r from-blue-500 to-indigo-600 py-4 px-6">
            <div class="flex items-center justify-center space-x-3">
                <div class="bg-white/20 p-3 rounded-full backdrop-blur-sm">
                    <i class="ri-book-2-line text-white text-2xl"></i>
                </div>
                <h1 class="text-2xl font-bold text-white">Pahana Edu Bookshop</h1>
            </div>
        </div>
        
        <!-- Login form -->
        <div class="bg-white p-8">
            <div class="text-center mb-8">
                <h2 class="text-2xl font-bold text-gray-800 mb-2">Welcome</h2>
                <p class="text-gray-600">Sign in to access your account</p>
            </div>
            
            <form method="post" action="<%= request.getContextPath() %>/login" class="space-y-6" id="loginForm">
                <!-- Error message from servlet -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded-lg flex items-start">
                        <i class="ri-error-warning-line text-xl mr-3 mt-0.5"></i>
                        <div>
                            <p class="font-medium"><%= request.getAttribute("error") %></p>
                            <p class="text-sm mt-1">Please check your credentials and try again</p>
                        </div>
                    </div>
                <% } %>
                
                <div class="space-y-4">
                    <!-- Username field -->
                    <div>
                        <label for="username" class="block text-sm font-medium text-gray-700 mb-2 flex items-center">
                            <i class="ri-user-3-line text-blue-500 mr-2"></i> Username
                        </label>
                        <div class="relative">
                            <input id="username" name="username" type="text" required
                                   class="input-focus w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 transition"
                                   placeholder="Enter your username"
                                   value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                            <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                <i class="ri-user-line text-gray-400"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Password field -->
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-2 flex items-center">
                            <i class="ri-lock-2-line text-blue-500 mr-2"></i> Password
                        </label>
                        <div class="relative">
                            <input id="password" name="password" type="password" required
                                   class="input-focus w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 transition"
                                   placeholder="Enter your password">
                            <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                <i class="ri-key-line text-gray-400"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Submit button -->
                <div>
                    <button type="submit" 
                            class="login-btn w-full flex justify-center items-center py-3 px-4 rounded-lg text-white font-medium shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        <i class="ri-login-box-line mr-2"></i>
                        Sign In
                    </button>
                </div>
            </form>
        </div>
        
        <!-- Footer -->
        <div class="bg-gray-50 px-6 py-4 text-center border-t border-gray-200">
            <p class="text-sm text-gray-500">
                Don't have an account? 
                <a href="<%= request.getContextPath() %>/#" class="font-medium text-blue-600 hover:text-blue-500">Contact administrator</a>
            </p>
        </div>
    </div>

    <script>
        // Simple animation for the login form
        document.addEventListener('DOMContentLoaded', () => {
            const form = document.querySelector('form');
            form.style.opacity = '0';
            form.style.transform = 'translateY(20px)';
            
            setTimeout(() => {
                form.style.transition = 'all 0.4s ease-out';
                form.style.opacity = '1';
                form.style.transform = 'translateY(0)';
            }, 100);
            
            // Add focus styles dynamically
            const inputs = document.querySelectorAll('input');
            inputs.forEach(input => {
                input.addEventListener('focus', () => {
                    input.parentElement.querySelector('label').classList.add('text-blue-600');
                });
                input.addEventListener('blur', () => {
                    input.parentElement.querySelector('label').classList.remove('text-blue-600');
                });
            });

            // Auto-hide success toast if present
            const successToast = document.getElementById('successToast');
            if (successToast) {
                setTimeout(() => {
                    successToast.classList.remove('show');
                }, 3000);
            }
        });
    </script>
</body>
</html>