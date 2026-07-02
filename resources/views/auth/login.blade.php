@extends('layouts.app')
@section('title', 'Login - dotProject+')

@section('content')
    <div class="container">
        <div class="row min-vh-100 d-flex align-items-center justify-content-center">
            <div class="col-md-6 col-lg-5 col-xl-4">
                <div class="card shadow-lg border-0 rounded-4">
                    <div class="card-body p-4 p-md-5">

                        <div class="text-center mb-4">
                            <img src="{{ asset('images/dotproject_plus_logo.jpg') }}" alt="Logo do dotProject+" class="img-fluid" style="max-width: 180px;">
                        </div>

                        <form method="POST" action="{{ route('login') }}">
                            @csrf

                            <div class="mb-3">
                                <label for="username" class="form-label fw-semibold text-secondary">Nome do Usuário</label>
                                <input
                                    id="username"
                                    type="text"
                                    name="username"
                                    class="form-control rounded-3 border-secondary-subtle @error('username') is-invalid @enderror"
                                    value="{{ old('username') }}"
                                    required
                                    autofocus>

                                @error('username')
                                <div class="invalid-feedback">
                                    {{ $message }}
                                </div>
                                @enderror
                            </div>

                            <div class="mb-4">
                                <label for="password" class="form-label fw-semibold text-secondary">Senha</label>
                                <input
                                    id="password"
                                    type="password"
                                    class="form-control rounded-3 border-secondary-subtle"
                                    name="password"
                                    required>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-dark btn-lg rounded-3 fw-bold shadow-sm" style="background-color: var(--dp-tab-on); border-color: var(--dp-tab-on);">
                                    Login
                                </button>
                            </div>
                        </form>

                        <div class="text-center text-muted small mt-4 pt-3 border-top border-light-subtle">
                            <p class="mb-2"><a href="#" class="text-decoration-none text-secondary link-hover-yellow">Esqueci meu nome de usuário e senha</a></p>
                            <p class="mb-2 text-secondary-50">versão 3.0</p>
                            <p class="mb-0 text-secondary-50">Cookies devem estar habilitados em seu navegador.</p>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
@endsection
