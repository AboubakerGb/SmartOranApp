document.addEventListener('DOMContentLoaded', function() {
    // Récupération des éléments
    const addEventBtn = document.getElementById('addEventBtn');
    const viewReportsBtn = document.getElementById('viewReportsBtn');
    const reportsSection = document.getElementById('reportsSection');
    const addEventSection = document.getElementById('addEventSection');
    const downloadReportBtn = document.getElementById('downloadReportBtn');
    const addEventForm = document.getElementById('addEventForm');

    // Au chargement, on s'assure que seule la section reports est visible
    reportsSection.classList.remove('hidden');
    addEventSection.classList.add('hidden');

    // Gestion du clic sur "Add Event"
    addEventBtn.addEventListener('click', function(e) {
        e.preventDefault();
        reportsSection.classList.add('hidden');
        addEventSection.classList.remove('hidden');
    });

    // Gestion du clic sur "View Reports"
    viewReportsBtn.addEventListener('click', function(e) {
        e.preventDefault();
        addEventSection.classList.add('hidden');
        reportsSection.classList.remove('hidden');
    });

    // Gestion du téléchargement de rapport
    downloadReportBtn.addEventListener('click', function(e) {
        e.preventDefault();
        alert('Report downloaded!');
        // Pour une vraie implémentation :
        // window.location.href = "/download-report";
    });

    // Gestion de la soumission du formulaire
    addEventForm.addEventListener('submit', function(e) {
        e.preventDefault();

        const eventData = {
            name: document.getElementById('eventName').value,
            date: document.getElementById('eventDate').value,
            participants: document.getElementById('participants').value,
            status: document.getElementById('status').value
        };

        // Ici, vous devriez envoyer les données à votre backend Flask
        console.log('Event data:', eventData);
        alert(`Event "${eventData.name}" saved successfully!`);

        // Réinitialisation du formulaire
        addEventForm.reset();

        // Retour à la vue des rapports
        addEventSection.classList.add('hidden');
        reportsSection.classList.remove('hidden');
    });
});
addEventForm.addEventListener('submit', function(e) {
    e.preventDefault();

    const eventData = {
        name: document.getElementById('eventName').value,
        date: document.getElementById('eventDate').value,
        participants: document.getElementById('participants').value,
        status: document.getElementById('status').value
    };

    // Envoi des données au serveur Flask
    fetch('/add-event', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(eventData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert(data.message);
            addEventForm.reset();
            addEventSection.classList.add('hidden');
            reportsSection.classList.remove('hidden');
            // Actualiser la liste des événements si nécessaire
        } else {
            alert('Error: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while saving the event');
    });
});