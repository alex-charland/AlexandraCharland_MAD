package com.example.lab8

data class Hotel(var hotelImage:Int = 0, var hotelDesc:String="", var hotelUrl:String=""){
    fun displayChoice(roomType: Int, imageID: Int, hotelMessage: String){
        setRoom(roomType,imageID)
        hotelDesc = hotelMessage
    }
    private fun setRoom(roomType:Int, imageID:Int) {
        when (roomType){
            0,1,2 -> hotelUrl = "https://www.ihg.com/holidayinnexpress/hotels/us/en/boulder/vboex/hoteldetail?qDest=Boulder,%20CO,%20United%20States&qCiD=22&qCoD=23&qCiMy=102020&qCoMy=102020&qAdlt=1&qChld=0&qRms=1&qWch=0&qSmP=1&qIta=99618783&setPMCookies=true&qRtP=6CBARC&qAAR=6CBARC&qSlH=VBOEX&qAkamaiCC=US&srb_u=1&qRad=30&qRdU=mi&qSHBrC=EX&presentationViewType=select&qSrt=sBR&qBrs=re.ic.in.vn.cp.vx.hi.ex.rs.cv.sb.cw.ma.ul.ki.va.ii.sp.nd.ct.sx"
            3 -> hotelUrl = "https://lanescove.org/the-little-shack/"
            else -> hotelUrl = ""
            }
        hotelImage = imageID
    }
}