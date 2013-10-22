[T4Scaffolding.Scaffolder(Description = "Enter a description here")][CmdletBinding()]
param(
	[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$Model,
	[string]$folderName,
	[string[]]$Properties,        
    [string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false
)

$outputPath = "Controllers\"+$folderName+"\"+$Model+"Controller"  # The filename extension will be added based on the template's <#@ Output Extension="..." #> directive
$outputViewPath = "Views\Partials\"+$folderName+"\"+$Model+"View"  # The filename extension will be added based on the template's <#@ Output Extension="..." #> directive
$namespace = (Get-Project $Project).Properties.Item("DefaultNamespace").Value
$modelName = $Model + "Model"
$foundModelType = Get-ProjectType $modelName -Project $Project -BlockUi -ErrorAction SilentlyContinue

"Lets start the waiting"

if(!$foundModelType){ Scaffold Type $modelName $Properties Models\$folderName }

$foundModelType = Get-ProjectType $modelName -Project $Project
if(!$foundModelType){ return }	

$modelTypeNameSpace = [T4Scaffolding.NameSpaces]::GetNameSpace($foundModelType.FullName)
Add-ProjectItemViaTemplate $outputPath -Template SurfaceControllerTemplate `
	-Model @{ 
			Namespace = $namespace; 
			FolderName = $foldername;
			ControllerName = $Model; 
			ModelNameSpace = $modelTypeNameSpace;  
			ModelType = [MarshalByRefObject]$foundModelType;
			ExampleValue = "Hello, world!" } `
	-SuccessMessage "Added SurfaceController output at {0}" `
	-TemplateFolders $TemplateFolders -Project $Project -CodeLanguage $CodeLanguage -Force:$Force


Add-ProjectItemViaTemplate $outputViewPath -Template SurfaceControllerViewTemplate `
	-Model @{ 
			Namespace = $namespace; 
			ModelName = $Model;
			FolderName = $foldername;
			ModelNamespace = $modelTypeNameSpace;  
			ModelType = [MarshalByRefObject]$foundModelType;
			ExampleValue = "Hello, world!" } `
	-SuccessMessage "Added View output at {0}" `
	-TemplateFolders $TemplateFolders -Project $Project -CodeLanguage $CodeLanguage -Force:$Force