const username = "<%= @username %>";

    function updateCharCount() {
        const postContent = document.getElementById('postContent').value;
        const charCount = postContent.length;
        const maxChars = 350;

        document.getElementById('charCount').textContent = `${charCount}/${maxChars}`;

        const postButton = document.getElementById('postButton');
        if (charCount > 0) {
          postButton.disabled = false; // Enable the button if there's text
        } else {
          postButton.disabled = true; // Disable the button if textarea is empty
        }
    }