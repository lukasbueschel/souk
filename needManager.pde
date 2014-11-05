import java.util.Map;

HashMap<String, Need> needs;

class NeedManager{
  NeedManager(){
    needs = new HashMap<String, Need>();
    //yellow
    needs.put("shopping", new Need("shopping", color(255,229,49), color(217, 191, 11)));
    //lila
    needs.put("toilet", new Need("toilet", color(172,34,232), color(96, 0, 156)));
    //blue
    needs.put("hunger", new Need("hunger", color(2, 142, 255), color(0, 66, 179)));
    //green
    needs.put("mosque", new Need("mosque", color(0,232,81), color(0, 156, 5)));
    //red
    needs.put("heat", new Need("heat", color(255, 52, 51), color(179, 0, 0)));
  }  
}
