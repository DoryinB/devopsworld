using devopsworld.Client.Controllers;
using Microsoft.AspNetCore.Mvc;
using Xunit;

namespace devopsworld.Test
{
  public class HomeUnitTest
  {
    [Fact]
    public void Test_Index()
    {
      var sut = new HomeController();
      var view = sut.Index(); //subject under test

      Assert.NotNull(view);
      Assert.IsType<ViewResult>(view);
    }
  
    [Fact]
    public void Test_Privacy()
    {
      var sut = new HomeController();
      var view = sut.Privacy(); //subject under test

      Assert.NotNull(view);
    }
  }
}
