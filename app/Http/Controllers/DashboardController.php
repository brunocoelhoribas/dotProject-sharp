<?php

namespace App\Http\Controllers;

use App\Models\Company\Company;
use App\Http\Services\DashboardService;
use Illuminate\Http\Request;

class DashboardController extends Controller {
    protected DashboardService $dashboardService;

    public function __construct(DashboardService $dashboardService) {
        $this->dashboardService = $dashboardService;
    }

    public function index(Request $request) {
        $filters = $request->only(['date_from', 'date_to', 'company_id']);
        $data = $this->dashboardService->getDashboardData($filters);
        $companies = Company::orderBy('company_name')->pluck('company_name', 'company_id');

        return view('home.index', array_merge($data, compact('companies', 'filters')));
    }
}
