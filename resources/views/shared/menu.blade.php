<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="{{ url('/') }}">Warehouse</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">

      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        @if(Auth::user()->role_id == 1 || Auth::user()->role_id == 2)
        <li class="nav-item">
          <a class="nav-link {{ request()->path() === 'import/index' ? 'active' : '' }}" href="{{ url('/import/index') }}">Nhập kho</a>
        </li>
        <li class="nav-item">
          <a class="nav-link {{ request()->path() === 'export/index' ? 'active' : '' }}" href="{{ url('/export/index') }}">Xuất kho</a>
        </li>
        <li class="nav-item">
          <a class="nav-link {{ request()->path() === 'pay/index' ? 'active' : '' }}" href="{{ url('/pay/index') }}">Thanh toán</a>
        </li>
        <li class="nav-item">
          <a class="nav-link {{ request()->path() === 'admin' ? 'active' : '' }}" href="{{ url('/admin') }}">Admin</a>
        </li>
        @endif
        @if(Auth::user()->role_id == 1 || Auth::user()->role_id == 2)
        <li class="nav-item">
          <a class="nav-link nav-hide {{ request()->path() === 'product/list' ? 'active' : '' }}" href="{{ url('/product/list') }}">Sản phẩm</a>
        </li>
        @endif
        @if(in_array(Auth::user()->role_id, [1,2,3,4]))
        <li class="nav-item">
          <a class="nav-link nav-hide {{ request()->path() === 'dept/list' ? 'active' : '' }}" href="{{ url('/dept/list') }}">Công nợ</a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-hide {{ request()->path() === 'import/list' ? 'active' : '' }}" href="{{ url('/import/list') }}">Danh sách nhập kho</a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-hide {{ request()->path() === 'pay/list' ? 'active' : '' }}" href="{{ url('/pay/list') }}">Danh sách thanh toán</a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-hide {{ request()->path() === 'dept/list-day' ? 'active' : '' }}" href="{{ url('/dept/list-day') }}">Công nợ theo ngày</a>
        </li>
        @endif
        @if(in_array(Auth::user()->role_id, [1,2,5]))
        <li class="nav-item">
          <a class="nav-link nav-hide {{ request()->path() === 'export/list' ? 'active' : '' }}" href="{{ url('/export/list') }}">Danh sách xuất kho</a>
        </li>
        @endif
      </ul>
      <div class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="dropdown03" data-bs-toggle="dropdown" aria-expanded="true">
              <img src="{{ Voyager::image( Auth::user()->avatar ) }}" class="avatar" alt="Avatar"> {{Auth::user()->name}} <b class="caret"></b>
            </a>
            <ul class="dropdown-menu" aria-labelledby="dropdown03" data-bs-popper="none">
              <a href="{{ url('/user/profile') }}" class="dropdown-item"><i class="fa fa-user-o"></i> Profile</a>
              <a href="#" class="dropdown-item"><i class="fa fa-calendar-o"></i> Calendar</a>
              <a href="#" class="dropdown-item"><i class="fa fa-sliders"></i> Settings</a>
              <div class="dropdown-divider"></div>
              <a href="{{ url('/logout') }}" class="dropdown-item"><i class="material-icons"></i> Logout</a>
            </ul>
      </div>
    </div>
  </div>
</nav>
