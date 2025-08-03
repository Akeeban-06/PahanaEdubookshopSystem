<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu Bookshop - Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen">
    <div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-md w-full space-y-8">
            <div class="text-center">
                <div class="mx-auto h-12 w-12 bg-indigo-600 rounded-full flex items-center justify-center">
                    <i class="fas fa-book text-white text-2xl"></i>
                </div>
                <h2 class="mt-6 text-3xl font-extrabold text-gray-900">
                    Pahana Edu Bookshop
                </h2>
                <p class="mt-2 text-sm text-gray-600">
                    Sign in to your account
                </p>
            </div>
            
            <form class="mt-8 space-y-6" method="post" action="login">
                <div class="bg-white p-8 rounded-xl shadow-lg">
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg">
                            <i class="fas fa-exclamation-circle mr-2"></i>
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>
                    
                    <div class="space-y-4">
                        <div>
                            <label for="username" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-user mr-2"></i>Username
                            </label>
                            <input id="username" name="username" type="text" required 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                                   placeholder="Enter your username">
                        </div>
                        
                        <div>
                            <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-lock mr-2"></i>Password
                            </label>
                            <input id="password" name="password" type="password" required 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                                   placeholder="Enter your password">
                        </div>
                    </div>
                    
                    <div class="mt-6">
                        <button type="submit" 
                                class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 transition duration-200">
                            <i class="fas fa-sign-in-alt mr-2"></i>
                            Sign In
                        </button>
                    </div>
                    
                    <div class="mt-4 text-center">
                        <div class="bg-gray-50 p-4 rounded-lg">
                            <p class="text-sm text-gray-600 font-medium">Demo Credentials:</p>
                            <p class="text-xs text-gray-500 mt-1">Username: admin | Password: admin123</p>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>