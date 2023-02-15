function password_toggle(e){ 
    $(`#${e.target.id}`).toggleClass('fa fa-eye fa fa-eye-slash'); 
    const password = document.querySelector('#password');
    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
    password.setAttribute('type', type);
}

function password_confirmation_toggle(e){ 
    $(`#${e.target.id}`).toggleClass('fa fa-eye fa fa-eye-slash'); 
    const password = document.querySelector('#password_confirmation');
    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
    password.setAttribute('type', type);
}