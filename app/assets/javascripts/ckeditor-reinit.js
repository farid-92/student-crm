$(document).bind('page:change', function() {

    var page = ($(".course_element_materials.new").length == 0);
    if (page) {
        return;
    }

    $('.ckeditor').each(function() {
        CKEDITOR.replace($(this).attr('id'),{
            language: 'ru',
            uiColor: '#FFFFFF',
            height: '400px',
            toolbar: 'standard'
        });
    });
});