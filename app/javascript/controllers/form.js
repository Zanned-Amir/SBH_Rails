document.addEventListener("DOMContentLoaded", function() {
    var form = document.getElementById("signup_form");

    form.addEventListener("submit", function(event) {
        var email = form.querySelector("#user_email").value;
        var password = form.querySelector("#user_password").value;
        var passwordConfirmation = form.querySelector("#user_password_confirmation").value;
        // Add validation for other fields as needed

        if (!isValidEmail(email)) {
            alert("Please enter a valid email address.");
            event.preventDefault();
            return false;
        }

        if (password.length < 8) {
            alert("Password must be at least 8 characters long.");
            event.preventDefault();
            return false;
        }

        if (password !== passwordConfirmation) {
            alert("Password and password confirmation do not match.");
            event.preventDefault();
            return false;
        }

        // Add validation for other fields as needed

        // If all validations pass, the form will be submitted
        return true;
    });

    function isValidEmail(email) {
        // Simple email validation regex
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }
});

  