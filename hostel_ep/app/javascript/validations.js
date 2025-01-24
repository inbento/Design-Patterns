document.addEventListener('DOMContentLoaded', function () {
  const passportField = document.querySelector('input[name="client[passport]"]');
  if (passportField) {
    passportField.addEventListener('input', function () {
      const hint = this.nextElementSibling;
      const isValid = /^\d{2} \d{2} \d{6}$/.test(this.value);
      if (!isValid) {
        hint.style.color = 'red';
      } else {
        hint.style.color = '#666';
      }
    });
  }
})