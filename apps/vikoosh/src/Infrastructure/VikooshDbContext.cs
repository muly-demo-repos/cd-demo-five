using Microsoft.EntityFrameworkCore;

namespace Vikoosh.Infrastructure;

public class VikooshDbContext : DbContext
{
    public VikooshDbContext(DbContextOptions<VikooshDbContext> options)
        : base(options) { }
}
