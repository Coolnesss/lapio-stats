$(document).on('ready', function(){

	window.toggleMluukkai = function(state) {
		$('body').toggleClass('easter', state);
	}

	$.fn.easterEgg = function(codes){
        var $this = $(this)
        var index =0
        $this.keyup(function(e){
            if (e.target.id === "search") return;
            if (codes[index]==e.which){
                if (++index >=codes.length){
                    toggleMluukkai();
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