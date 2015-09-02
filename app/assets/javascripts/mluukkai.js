$(document).on('ready', function(){
	$.fn.easterEgg = function(codes){
        var $this = $(this)
        var index =0
        $this.keyup(function(e){
            
            if (codes[index]==e.which){
                if (++index >=codes.length){
                    $('body').toggleClass('easter')
                    index=0
                }
            }else{
                index=0
            }
        })
        return $this;
    }
    $(document).easterEgg([77,76,85,85,75, 75,65,73]);
});