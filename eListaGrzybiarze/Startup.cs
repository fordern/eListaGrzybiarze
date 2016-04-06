using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(eListaGrzybiarze.Startup))]
namespace eListaGrzybiarze
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
