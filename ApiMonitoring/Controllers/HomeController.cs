using Microsoft.AspNetCore.Mvc;


namespace ApiMonitoring.Controllers
{
    [ApiController]
    public class HomeController : ControllerBase
    {
        [HttpGet]
        [Route("healthcheck")]
        public IActionResult Get()
        {
            return Ok("Healthy");
        }
    }
}
