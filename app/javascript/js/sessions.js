function google() { 
    return true
}

function facebook() {
    return false
}

function twitter2() {
    event.preventDefault()
}

function linkedin() {
    return false
}

function password_toggle(e){ 
    $(`#${e.target.id}`).toggleClass('fa fa-eye fa fa-eye-slash'); 
    const password = document.querySelector('#password');
    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
    password.setAttribute('type', type);
}