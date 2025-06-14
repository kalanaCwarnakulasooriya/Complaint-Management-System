document.getElementById('signupForm').addEventListener('submit', function(e) {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const username = document.getElementById('username').value.trim();
    const existingUsernames = JSON.parse(document.getElementById('existingUsernames').value);

    if (password !== confirmPassword) {
        e.preventDefault();
        Swal.fire({ icon: "error", title: "Password Mismatch", text: "Please make sure password match" });
    } else if (existingUsernames.includes(username)) {
        e.preventDefault();
        Swal.fire({ icon: "warning", title: "Username Taken", text: "Please choose another username" });
    }
});

function togglePassword() {
    const password = document.getElementById('password');
    const icon = document.querySelectorAll('.toggle-password i')[0];
    if (password.type === 'password') {
        password.type = 'text';
        icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
        password.type = 'password';
        icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
}

function toggleConfirmPassword() {
    const confirmPassword = document.getElementById('confirmPassword');
    const icon = document.querySelectorAll('.toggle-password i')[1];
    if (confirmPassword.type === 'password') {
        confirmPassword.type = 'text';
        icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
        confirmPassword.type = 'password';
        icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
}