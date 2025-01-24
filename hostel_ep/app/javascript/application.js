// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./validations"
import "@rails/ujs"
import Rails from "@rails/ujs"
Rails.start()

document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('a[data-method="delete"]').forEach(function (link) {
    link.addEventListener('click', function (event) {
      event.preventDefault();
      if (confirm('Вы уверены?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = link.href;
        form.style.display = 'none';

        const methodInput = document.createElement('input');
        methodInput.type = 'hidden';
        methodInput.name = '_method';
        methodInput.value = 'DELETE';

        const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
        const csrfInput = document.createElement('input');
        csrfInput.type = 'hidden';
        csrfInput.name = 'authenticity_token';
        csrfInput.value = csrfToken;

        form.appendChild(methodInput);
        form.appendChild(csrfInput);
        document.body.appendChild(form);
        form.submit();
      }
    });
  });
});