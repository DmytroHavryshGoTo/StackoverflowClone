$('.single-answer .edit').click(function (e) {
    e.preventDefault()
    $(this).hide()
    const answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()
    $('form#edit-answer-' + answer_id).closest('.body').hide()
})