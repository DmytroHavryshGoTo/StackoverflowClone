$('.single-answer .edit').click(function (e) {
    e.preventDefault()
    $(this).hide()
    const answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()
    $('form#edit-answer-' + answer_id).closest('.body').hide()
})

$(document).ready(function() {
    $(".single-answer a.add_fields").
    data("association-insertion-method", 'append').
    data("association-insertion-node", function(link){
        return link.prev('.form-group')
    });
    $(".single-answer a.add_fields").click((e) => {
        console.log(('tes'))
    })
});
