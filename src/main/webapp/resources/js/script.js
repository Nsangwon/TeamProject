/**
 * 
 */
function fileUploadInput( filename){
		
		var msg = `
      <input name= file type="file" value="${filename}" multiple="multiple">
      <img src = "${filename}">
      
   `;
   return msg;
}